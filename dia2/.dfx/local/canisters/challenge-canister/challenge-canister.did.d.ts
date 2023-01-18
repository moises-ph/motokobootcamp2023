import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'average_array' : ActorMethod<[Array<bigint>], bigint>,
  'convert_to_binary' : ActorMethod<[bigint], string>,
  'count_character' : ActorMethod<[string, number], bigint>,
  'factorial' : ActorMethod<[bigint], bigint>,
  'find_duplicates' : ActorMethod<[Array<bigint>], Array<bigint>>,
  'number_of_words' : ActorMethod<[string], bigint>,
}
