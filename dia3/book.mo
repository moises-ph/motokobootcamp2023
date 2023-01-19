module Books{
    public type Book = {
        Title : Text;
        Pages : Nat;
    };

    public func create_book(title : Text, pages : Nat) : Book{
        return { Title = title; Pages = pages; } : Book;
    };
}