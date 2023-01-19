import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Book { 'Pages' : bigint, 'Title' : string }
export interface _SERVICE {
  'add_book' : ActorMethod<[Book], undefined>,
  'get_books' : ActorMethod<[], Array<Book>>,
}
