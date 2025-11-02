import Scenarist from './prerequisites/scenarist.js';
import Logic from './logic/index.js';

const page = window .page = Object .assign ( document .body .appendChild ( document .create ( 'article' ) ), {

id: 'page',
innerHTML: `

<h1>
16 Is the New 12
</h1>

` .trim ()

} );

window .scenarist = new Scenarist ( new Logic )
.publish ()
.catch ( error => Object .assign ( page .appendChild ( 'section' ), {

id: 'error-' + Date .now (),
innerHTML: `

<h2>Shit at ${ error .filename }:${ error .lineno }</h2>

${ error .message }

` .trim ()

} ) )
