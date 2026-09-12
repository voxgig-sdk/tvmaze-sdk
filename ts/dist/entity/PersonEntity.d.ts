import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Person, PersonLoadMatch, PersonListMatch } from '../TvmazeTypes';
declare class PersonEntity extends TvmazeEntityBase<Person> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: PersonEntity): PersonEntity;
    load(this: any, reqmatch?: PersonLoadMatch, ctrl?: Control): Promise<PersonEntity>;
    list(this: any, reqmatch?: PersonListMatch, ctrl?: Control): Promise<PersonEntity[]>;
}
export { PersonEntity };
