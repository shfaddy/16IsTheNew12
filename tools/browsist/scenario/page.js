export default class Page {

async $_producer ( { play: $ }, details ) {

this .details = Object .assign ( Object .create ( details ), { page: this, $page: $ } );
this .context = await details .browser .newPage ();

};

async $_director () {

const script = await import ( './browsist.js' )
.catch ( () => false );

if ( typeof script ?.default !== 'function' )
throw "No script to run!";

return this .context .evaluate ( script .default );

};

async $go ( _, resource ) {

if ( resource === undefined )
throw "Where should the page be navigated to?";

await this .context .goto ( new URL ( resource ) );

return true;

};

};
