import Http "http";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";

actor{
    public type HttpRequest = Http.HttpRequest;
    public type HttpResponse = Http.HttpResponse;

    stable var CurrentText : Text = "Core-Project Motoko Bootcamp 2023";

    let BadRequest : HttpResponse = {
                        body = Text.encodeUtf8("Error: Bad Request");
                        headers = [];
                        status_code = 401;
                        streaming_strategy = null;
                    };

    private func update_text(t : ?Text) : (){
        CurrentText := Option.get(t , CurrentText);
    };

    public query func http_request(req : HttpRequest): async HttpResponse{
        
        switch(req.method){
            case("POST"){
                if(req.body != ""){
                    update_text(Text.decodeUtf8(req.body));
                    return({
                        body = Text.encodeUtf8("Text Updated Succesfully!!");
                        headers = [];
                        status_code = 200;
                        streaming_strategy = null;
                    });
                }else{
                    return(BadRequest);
                }
            };
            case("GET"){
                return({
                    body = Text.encodeUtf8(CurrentText);
                    headers = [];
                    status_code = 200;
                    streaming_strategy = null;
                });
            };
            case(_){
                return(BadRequest);
            }
        }
    };


}