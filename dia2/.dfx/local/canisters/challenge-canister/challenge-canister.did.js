export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'average_array' : IDL.Func([IDL.Vec(IDL.Nat)], [IDL.Nat], []),
    'count_character' : IDL.Func([IDL.Text, IDL.Nat32], [IDL.Nat], []),
  });
};
export const init = ({ IDL }) => { return []; };
