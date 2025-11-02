import Parameter from './parameter.js';

export default class Controller {

constructor ( setting = {} ) {

this .setting = Object .assign ( Object .create ( setting ), { controller: this } );

};

$_producer () {

if ( typeof this .setting .parameters === 'object' )
for ( const parameter of Object .keys ( this .setting .parameters ) )
this [ '$' + parameter ] = new Parameter ( this .setting .parameters [ parameter ] );

};

[ '$--parameter' ] = Parameter;

async [ '$--fields' ] ( { play: $ } ) {

return Promise .all (

( await $ ( '--directory', 'Parameter' ) )
.map (

( [ type, parameter ] ) => $ ( parameter, '--wrapped' )

)

);

};

async $_director ( { play: $ } ) {

return Promise .all (

( await $ ( '--directory', 'Parameter' ) ) .map (

async ( [ type, parameter ] ) => [ parameter, await $ ( parameter ) ] .join ( ' = ' )

)

);

};

};
