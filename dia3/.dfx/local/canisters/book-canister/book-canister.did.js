export const idlFactory = ({ IDL }) => {
  const Book = IDL.Record({ 'Pages' : IDL.Nat, 'Title' : IDL.Text });
  return IDL.Service({
    'add_book' : IDL.Func([Book], [], []),
    'get_books' : IDL.Func([], [IDL.Vec(Book)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
