import Page from '@shfaddy/browsist/page';
import puppeteer from 'puppeteer';

export default class Browsist {

async $_producer ( { play: $, interrupt }, details = {} ) {

this .details = Object .assign ( Object .create ( details ), {

browsist: this,
$browsist: $

} );

this .browser = details .browser = await puppeteer .launch ();

};

$page = Page;

};
