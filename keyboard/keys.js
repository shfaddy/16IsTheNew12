import { writeFile } from 'node:fs/promises';

const scale = [];

for ( let tone = 0; tone < 16; tone++ )
scale [ tone ] = tone;

const keys = new Set ( (

"zxcvasdfqwer1234"
+ "m,./jkl;uiop7890"

) .split ( '' )
.map ( key => ( { key, code: key .charCodeAt ( 0 ) } ) ) );

await writeFile ( 'keys.md', [

"# Keys",

"```scenario oscilla",

[ ... keys ] .map (

( { key, code }, index ) => {

const tone = ( 16 * parseInt ( index / 16 ) )
+ scale [ index % 16 ]

return `gkTone [ ${ code } ] init ${ tone }`;

}

) .join ( '\n' ),

"```"

] .join ( '\n\n' ), 'utf8' );
