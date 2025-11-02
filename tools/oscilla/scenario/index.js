import Code from '@shfaddy/oscilla/code';
import Instrument from '@shfaddy/oscilla/instrument';
import { readFile, writeFile } from 'node:fs/promises';
import { spawn } from 'node:child_process';

export default class Oscilla {

constructor ( setting = {} ) {

this .setting = Object .assign ( setting, {

oscilla: this,
instruments: 0,
score: new Code

} );

};

[ '$--options' ] = new Code;

[ '$--header' ] = new Code;

[ '$--instrument' ] = Instrument;

get [ '$+' ] () { return this .setting .score };

get [ '$--score' ] () { return this .setting .score };

async [ '$--code' ] ( { play: $ } ) {

const code = [];

code .push ('<CsoundSynthesizer>' );

code .push ( '<CsOptions>' );

const options = await $ ( '--options' );

if ( options .length )
code .push ( options );

code .push ( '</CsOptions>' );

code .push ( '<CsInstruments>' );

const header = await $ ( '--header' );

if ( header .length )
code .push ( header );

const orchestra = await $ ( '--directory', 'Instrument' )
.then ( orchestra => orchestra .map ( ( [ type, instrument ] ) => instrument ) );

const instruments = await Promise .all ( orchestra .map (

instrument => $ ( instrument, '--code' )

) );

if ( instruments .length )
code .push ( instruments .join ( '\n\n' ) );

code .push ( '</CsInstruments>' );

code .push ( '<CsScore>' );

const score = await $ ( '--score' );

if ( score .length )
code .push ( score );

code .push ( '</CsScore>' );

code .push ( '</CsoundSynthesizer>' );

return code .join ( '\n\n' );

};

async $_director ( { play: $, interrupt }, ... argv ) {

if ( argv .length )
throw "What?";

const path = 'oscilla.csd';

await writeFile ( path, await $ ( '--code' ), 'utf8' );

this .process = spawn ( 'csound', [ '--logfile=oscilla.log', path ], { stdio: 'ignore' } );

interrupt .then (

() => this .process ? this .process .kill ( 'SIGINT' ) : undefined

);

return await new Promise ( ( resolve, reject ) => {

this .process .on ( 'exit', ( ... status ) => {

delete this .process;

resolve ( [

"Finished playing Oscilla with status:",
status = status .filter ( status => status !== null ) .pop ()

] );

} );

} );

};

};
