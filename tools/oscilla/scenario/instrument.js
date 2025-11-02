import Controller from '@shfaddy/oscilla/controller';
import Code from '@shfaddy/oscilla/code';

export default class Instrument extends Controller {

constructor ( setting = {} ) {

super ( setting );

this .note = ++setting .instruments;

Object .assign ( this .setting, {

instrument: this,
parameters: {

note: { value: this .note },
step: { value: '0' },
length: { value: '0' }

}

} );

};

storage = new Map;
instance = 0;

async [ '$--instance' ] ( { play: $ }, ... argv ) {

if ( ! argv .length )
throw "What would the name of the new instrument instance be?";

const instance = argv .shift ();

if ( ! this .storage .has ( instance ) )
this .storage .set ( instance, ++this .instance % 10 === 0 ? ++this .instance : this .instance );

await $ ( 'note', '=', `${ this .note }.${ this .storage .get ( instance ) }` );

return true;

};

[ '$--header' ] = new Code;

[ '$--body' ] = new Code;

async [ '$*' ] ( { play: $ }, ... argv ) {

await Promise .all ( ( await $ ( '--directory', 'Instrument' ) ) .map (

( [ type, instrument ] ) => $ ( instrument, '*', ... argv )

) );

if ( argv .length )
await $ ( 'step', '=', argv .shift () );

if ( argv .length ) {

const [ tone, ornament ] = argv .shift () .split ( ':' );

await $ ( 'tone', '=', tone );

if ( ornament !== undefined )
await $ ( 'ornament', '=', ornament );

}

if ( argv .length )
await $ ( 'length', '=', argv .shift () );

await $ ( '+', ( [ 'i', ... await $ ( '--fields' ) ] .join ( ' ' ) ) );

return argv .length ?
$ ( '*', await $ ( 'step', '--value' ), `${ await $ ( 'tone', '--value' ) } + ${ argv .shift () }`, await $ ( 'length', '--value' ), ... argv )
: true;

};

get [ '$+' ] () { return this .setting .score };

get [ '$--score' ] () { return this .setting .score };

async [ '$--parameters' ] ( { play: $ } ) {

const format = [];
const values = [];
const parameters = await Promise .all ( ( await $ ( '--directory', 'Parameter' ) )
.map ( async ( [ type, parameter ], index ) => {

const field = 'p' + ++index
const code = [ `#define p_${ parameter } #${ field }#` ];
const capitalized = parameter [ 0 ] .toUpperCase () + parameter .slice ( 1 );
let variable;

if ( await $ ( parameter, '--type' ) === 'number' ) {

code .push ( `${ variable = ( 'iP' + capitalized ) } init ${ field }` );
format .push ( '%f' );
values .push ( variable );

} else {

code .push ( `${ variable = ( 'SP' + capitalized ) } strget ${ field }` );
format .push ( '"%s"' );
values .push ( variable );

}

return code .join ( '\n' );

} ) );

return [

... parameters,
... ( format .length > 3 ? [ `#define parameters #SParameters sprintf {{${ format .slice ( 3 ) .join ( ' ' ) }}}, ${ values .slice ( 3 ) .join ( ', ' ) }#` ] : [] )

];

};

async [ '$--parameters-index' ] ( { play: $ } ) {

return $ ( '+', ( await Promise .all ( ( await $ ( '--directory', 'Parameter' ) )
.map (

async ( [ type, parameter ], index ) => `#define p_${ parameter } #p${ ++index }#`

) ) ) .join ( '\n' ) );

};

async [ '$--code' ] ( { play: $ } ) {

const code = [];

const header = await $ ( '--header' );

if ( header .length )
code .push ( header );

code .push ( `#define ${ await $ ( '--direction' ) } #${ this .note }#` );

code .push ( `instr $${ await $ ( '--direction' ) }, ${ await $ ( '--direction' ) }` );

const parameters = await $ ( '--parameters' );

if ( parameters .length )
code .push ( parameters .join ( '\n' ) );

const body = await $ ( '--body' );

if ( body .length )
code .push ( body );

code .push ( 'endin' );

return code .join ( '\n\n' );

};

};
