import List "mo:base/List";
import Books "book";

actor{
    public type Book = Books.Book;
    public type BookLists = List.List<Book>;

    var myBook : Book = Books.create_book("Mi libro" , 100);
    var StoredBooks : BookLists = List.nil<Book>(); 

    public func add_book(book : Book) : async (){
        StoredBooks := List.push<Book>(book, StoredBooks);
    };

    public query func get_books() : async [Book]{
        return List.toArray<Book>(StoredBooks);
    };
}