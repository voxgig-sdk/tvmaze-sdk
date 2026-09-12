import { TvmazeEntityBase } from '../TvmazeEntityBase';
import type { TvmazeSDK } from '../TvmazeSDK';
import type { Control } from '../types';
import type { Search, SearchLoadMatch } from '../TvmazeTypes';
declare class SearchEntity extends TvmazeEntityBase<Search> {
    constructor(client: TvmazeSDK, entopts: any);
    make(this: SearchEntity): SearchEntity;
    load(this: any, reqmatch?: SearchLoadMatch, ctrl?: Control): Promise<SearchEntity>;
}
export { SearchEntity };
