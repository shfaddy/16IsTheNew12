#!/usr/bin/env node

import Browsist from '@shfaddy/browsist';
import Scenarist from '@shfaddy/scenarist/shell';

try {

await new Scenarist ( new Browsist, {

prefix: [ 'browsist' ]

} ) .publish ();

} catch ( error ) {

console .error ( "Browsist got killed!" );
console .error ( error );

}
