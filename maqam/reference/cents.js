const scale = process .argv .slice ( 2 ) .map ( argument => parseFloat ( argument ) );
const root = scale .shift ();

console .log ( [

0,
... scale .map ( frequency => parseInt ( 1200 * Math .log2 ( frequency / root ) ) )

] .join ( '\n' ) );
