export default class Code extends Array {

$_director ( _, ... argv ) {

if ( ! argv .length )
return this .join ( '\n' );

return this .push ( argv .join ( ' ' ) );

};

};
