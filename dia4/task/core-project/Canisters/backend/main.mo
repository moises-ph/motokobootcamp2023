import Principal "mo:base/Principal";
import Proposals "Proposals";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Result "mo:base/Result";
import Bool "mo:base/Bool";
import Cycles "mo:base/ExperimentalCycles";



shared ({ caller = owner }) actor class Backend() = {
    stable var creator : Principal = owner;
    type Err ={
        #Unauthorized;
        #ProposalNotFound;
        #NotEnoughCycles;
        #AnonymusUser
    };

    type Succes = {
        #TaskCompletedSuccesfully;
        #UserLogedInSuccesfully : Bool;
    };

    /////////////////
    //////Users//////
    /////////////////

    stable var ArrUsers : [Principal] = [];

    private func validate_user(user : Principal) : Bool{
        var isUser : ?Principal = Array.find<Principal>(ArrUsers, func x = x == user);
        switch(isUser){ case(null) false; case(? existentUser) true; };
    };

    ///////////////////////////
    //////Users Functions//////
    ///////////////////////////

    public shared ({ caller = user }) func login_users(newUser : Principal): async Result.Result<Succes, Err>{
        let isUser : ?Principal = Array.find<Principal>(ArrUsers, func x = x == newUser);
        switch(isUser){
            case(null){
                if(Principal.isAnonymous(newUser)){
                    #err(#AnonymusUser);
                }else{
                    ArrUsers := Array.append(ArrUsers, [newUser]);
                    #ok(#UserLogedInSuccesfully(true));
                };
            };
            case(? user){
                #ok(#UserLogedInSuccesfully(true));
            };
        }
    };

    //////////////////
    //////Cycles//////
    //////////////////

    let price : Nat = 1_000_000_000;

    /////////////////////
    //////Proposals//////
    /////////////////////

    public type Proposal = Proposals.Proposal;
    stable var ArrDataProposals : [Proposal] = [];
    var DataProposals = HashMap.HashMap<Nat,Proposal>(0 , Nat.equal, Hash.hash);
    stable var ProposalsCounter : Nat = 0;

    ///////////////////////////////
    //////Proposals Functions//////
    ///////////////////////////////    

    // Admin Function ONLY!!!! DELETE
    public shared({ caller = user }) func delete_proposal(id : Nat) : async Result.Result<Succes, Err>{
        if(user == creator){
            var proposal : ?Proposal = DataProposals.get(id);
            switch(proposal) {
                case(null) { #err(#ProposalNotFound) };
                case(? p) { 
                    ignore DataProposals.remove(id);
                    #ok(#TaskCompletedSuccesfully);
                 };
            };
        }else{
            #err(#Unauthorized);
        }
    };

    // CREATE
    public shared({caller = user}) func create_proposal(p : Proposal) : async Result.Result<Succes, Err>{
        if(validate_user(user)){
            ProposalsCounter += 1;
            let id : Nat = ProposalsCounter;
            var newProposal : Proposal = p;
            DataProposals.put(id, newProposal);
            #ok(#TaskCompletedSuccesfully);
        }else{
            #err(#Unauthorized);
        };
    };

    // UPDATE (Votes Only)
    public shared({ caller = user }) func vote_proposal(id : Nat, vote : Bool) : async Result.Result<Succes, Err>{
        if(validate_user(user)){
            let cycles = Cycles.available();
            if(cycles < price){
                #err(#NotEnoughCycles);
            }else{
                ignore Cycles.accept(price);

                var currentProposal : ?Proposal = DataProposals.get(id);
                switch(currentProposal){
                    case(null) #err(#ProposalNotFound);
                    case(? proposal){
                        if(vote){
                            var votedProposal : Proposal = {
                                user_proposer = proposal.user_proposer;
                                body = proposal.body;
                                votes ={
                                    Yes = proposal.votes.Yes + cycles;
                                    No = proposal.votes.No;
                                };
                            };
                            DataProposals.put(id, votedProposal);
                            #ok(#TaskCompletedSuccesfully);
                        }else{
                            var votedProposal : Proposal = {
                                user_proposer = proposal.user_proposer;
                                body = proposal.body;
                                votes ={
                                    Yes = proposal.votes.Yes;
                                    No = proposal.votes.No +  cycles;
                                };
                            };
                            DataProposals.put(id , votedProposal);
                            #ok(#TaskCompletedSuccesfully);
                        };
                    };
                }
            };
        }else{
            #err(#Unauthorized);
        }
    };

    //READ
    public query func ver_propuestas() : async [Proposal]{
        Iter.toArray<Proposal>(DataProposals.vals());
    };

    system func preupgrade(){
        ArrDataProposals := Iter.toArray<Proposal>(DataProposals.vals());
    };

    system func postupgrade(){
        // DataProposals := HashMap.fromIter<Nat, Proposal>(ArrDataProposals.vals(), ProposalsCounter, Nat.equal, Hash.hash);
        // ERR: expression of type
        //   {next : () -> ?Proposal__1}
        // cannot produce expected type
        //   {next : () -> ?(Nat, Proposal__1)}Motoko
        // So I did it this way:
        var counter : Nat = 1;
        for(proposal in ArrDataProposals.vals()){
            DataProposals.put(counter, proposal);
            counter += 1;
        };
        ArrDataProposals := [];
    };

}