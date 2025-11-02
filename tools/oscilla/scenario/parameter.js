export default class Parameter {

value = '0';

book = new Map;

constructor ( setting = {} ) {

this .setting = setting;

if ( setting .value !== undefined )
this .value = setting .value;

};

$_producer ( { play: $ } ) {

return $ ( '--number' );

};

$_prepare ( _, scenario ) { Object .assign ( this, scenario ) };

$_director ( { play: $ }, ... argv ) {

return $ ( '--combination' );

};

[ '$=' ] ( { play: $ }, value, ... argv ) {

if ( value === undefined )
throw "Undefined value";

this .value = value;

if ( argv .length )
return $ ( '..', ... argv );

return $ ();

};

get [ '$--value' ] () { return this .value };

get [ '$--raw' ] () { return [ this .value, ... this .attachment ] .join ( ' ' ) };

get [ '$--processed' ] () {

let value = [];

for ( const entry of [ this .value, ... this .attachment ] )
value .push (

! this .system || isNaN ( entry ) ? entry : parseInt ( entry, this .system )

);

return value .join ( ' ' );

};

[ '$--system' ] ( _, system ) {

if ( system === undefined )
return this .system;

if ( isNaN ( system = parseInt ( system ) ) )
throw "Numeric system is required to be a number";

return this .system = system;

};

async [ '$--combination' ] ( { play: $ } ) {

const value = await $ ( '--processed' );
const senior = await $ ( '--location', '..', '..', await $ ( '--direction' ) );

if ( ! senior || senior .join ( ' ' ) === ( await $ ( '--location' ) ) .join ( ' ' ) )
return value;

const combination = [];

combination .push (

await $ ( '..', '..', await $ ( '--direction' ), '--combination' ),
value

);

combination .splice ( 0, combination .length, combination .join ( this .combinator [ 0 ] || ' ' ) );

if ( this .combinator [ 1 ] !== undefined )
combination .unshift ( this .combinator [ 1 ] );

if ( this .combinator [ 2 ] )
combination .push ( this .combinator [ 2 ] );

return combination .join ( '' );

};

get [ '$--type' ] () { return this .type };

[ '$--number' ] ( { play: $ }, ... argv ) {

this .type = 'number';
this .combinator = [ '+', '(', ')' ];
this .wrapper = [ '[', ']' ];

return $ ( ... argv );

};

[ '$--combinator' ] ( { play: $ }, ... argv ) {

if ( argv .length )
this .combinator .splice ( 0, argv .length, ... argv );

return $ ();

};

[ '$--wrapper' ] ( { play: $ }, ... argv ) {

switch ( argv .length ) {

case 0:

return this .wrapper .join ( '' );

case 1:

return ( this .wrapper = argv [ 0 ] === 'none' ? [] : argv ) .join ( '' );

case 2:

return ( this .wrapper = argv ) .join ( '' );

default:

throw "Invalid wrapper";

}

};

[ '$--string' ] ( { play: $ }, ... argv ) {

this .type = 'string';
this .combinator = [ ' ', '', '' ];
this .wrapper = [ '"', '"' ];

return $ ( ... argv );

};

async [ '$--wrapped' ] ( { play: $ } ) {

return [ this .wrapper [ 0 ], await $ ( '--combination' ), this .wrapper [ 1 ] ] .join ( '' );

};

persistence = 'variable';

get [ '$--persistence' ] () { return this .persistence };

[ '$--variable' ] () { return ( this .persistence = 'variable' ), true };

[ '$--constant' ] () { return ( this .persistence = 'constant' ), true };

[ '$--define' ] ( _, key, value ) {

if ( key === undefined )
throw "Provide a key for this parameter to define";

if ( value !== undefined )
this .book .set ( key, value );

return this .book .get ( key );

};

attachment = [];

[ '$--attach' ] ( _, ... argv ) {

this .attachment = argv .length ? [ ... this .attachment, ... argv ] : [];

return _ .play ();

};

};
