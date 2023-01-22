import React from 'react'
import { useContext, useEffect, useState } from 'react';
import Swal from 'sweetalert2'
import withReactContent from 'sweetalert2-react-content'
import Context from '../context/DAOContext';
import { ContextProvider } from '../context/DAOContext';
import { idlFactory as idlFactoryDAO } from '../.dfx/ic/canisters/backend/backend.did.js';


function Proposals() {
    const [proposals, setProp] = useState([]);
    const MySwal = withReactContent(Swal)
    const canisterId = 'b3ysv-piaaa-aaaag-abepq-cai';
    const { loged } = useContext(ContextProvider);

    const getProposals = async () =>{
        console.log(loged);
        if(loged){
            const dao = await window.ic.plug.createActor({
                canisterId: canisterId,
                interfaceFactory : idlFactoryDAO
              });
            console.log(dao);
            let res = await dao.list_proposals();
            console.log('Proposals', res);
            setProp(res);
        }else{
            MySwal.fire('Error','You are not Connected, please connect with the Plug extension', 'error')
        }
    };

    useEffect(() => {
      getProposals();
    }, [loged]);
    

  return (
    <>
        <Context>
            <h2 className='anim_start font-medium text-4xl'>Proposals</h2>
            <div>{proposals.map(value =><>
                value
            </>)}</div>
        </Context>
    </>
  )
}

export default Proposals