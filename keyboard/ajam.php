<!-- Author: Filip Todorov www.filiptodorov.com -->
<!doctype html>
<html lang="en" >
  <head>
      <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-127759510-1"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'UA-127759510-1');
    </script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- SEO tags -->
    <meta name="description" content="Jins ‘Ajam">
    <meta name="keywords" content="arabic, music, arab, world, maqam, jins, ‘ajam, ajam, oud, qanun, nay, quarter tone, tetrachord, modal, middle east">
    <meta name="author" content="Johnny Farraj">

    <!-- Page settings -->
    <title>Jins ‘Ajam</title>
    <link rel="icon" href="/img/favicon.png">

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font-awesome.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/css/style.css" rel="stylesheet">
    <link href="/css/fonts.css" rel="stylesheet">
    <link href="/css/plyr.css" rel="stylesheet">
    <link href="/css/owl.carousel.min.css" rel="stylesheet">
    <link href="/css/owl.theme.default.min.css" rel="stylesheet">

    <script src="/js/jquery-3.3.1.min.js"></script>

  </head>
  <body class="jins-page">

        <header>
        <!-- Logo and Search bar -->
        <div class="container">
            <!-- Logo -->
            <a href="/en/index.php" class="logo"><img src="/img/logo.jpg"></a>

            <!-- Mobile Toggler -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarDefault" aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="clearfix d-block d-md-none"></div>

            <!-- Search bar -->
                        <form class="search-bar" action="/en/results.php" method="get">
                <input type="search" placeholder="Search" class="form-control" name="search" autocomplete="off" name="q">
                <button type="submit"><i class="fa fa-fw fa-search"></i></button>
            </form>
            
            <!-- Language Selector -->
                        <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    English                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="#">English</a><a class="dropdown-item" href="/ar/jins/ajam.php">العربية</a><a class="dropdown-item" href="/fr/jins/ajam.php">Français</a><a class="dropdown-item" href="/de/jins/ajam.php">Deutsch</a><a class="dropdown-item" href="/it/jins/ajam.php">Italiano</a><a class="dropdown-item" href="/el/jins/ajam.php">Ελληνικά</a><a class="dropdown-item" href="/es/jins/ajam.php">Español</a><a class="dropdown-item" href="/pt/jins/ajam.php">Português</a>                </div>
            </div>

            <!-- Clearfix (DO NOT REMOVE) -->
            <div class="clearfix"></div>
        </div>

        <!-- Language Navigation -->
        <nav class="navbar navbar-expand-md navbar-dark bg-dark">
            <div class="container">
                <!-- Navbar -->
                	                <!-- Navbar -->
<div class="collapse navbar-collapse" id="navbarDefault">
	<ul class="navbar-nav mr-auto">
		<li class="nav-item ">
			<a class="nav-link" href="/en/index.php"><i class="fa fa-fw fa-home"></i></a>
		</li>
		<li class="nav-item ">
			<a class="nav-link" href="/en/instr.php">Instruments</a>
		</li>
		<li class="nav-item ">
			<a class="nav-link" href="/en/forms.php">Forms</a>
		</li>
		<li class="nav-item ">
			<a class="nav-link" href="/en/jins.php">Jins</a>
		</li>
		<li class="nav-item ">
			<a class="nav-link" href="/en/maqam.php">Maqam</a>
		</li>
		<li class="nav-item ">
			<a class="nav-link" href="/en/iqaa.php">Rhythms</a>
		</li>
		<li class="nav-item ">
			<a class="nav-link" href="/en/book.php">Publications</a>
		</li>
	</ul>
</div>
                            </div>
        </nav>
    </header>

    <!-- Pronuncation player -->
    <div style="opacity:0;visibility:hidden;position:absolute;z-index:-99;">
        <audio id="pronunciation-player" controls>
            <source src="/name/ajam.mp3" type="audio/mp3">
        </audio>
    </div>

    <div class="page">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <a href="#" class="show-side-menu d-none d-md-block btn btn-primary above-list"><i class="fa fa-fw fa-bars"></i> Jins Index</a>
                    <ul class="sub-menu">
    <li class="d-block d-sm-none"><a href="#" class="hide-side-menu"><i class="fa fa-fw fa-times"></i></a></li>

    <li><a href="/en/jins/ajam.php">‘Ajam</a></li>
    <li><a href="/en/jins/ajam_murassaa.php">‘Ajam Murassa‘</a></li>
    <li><a href="/en/jins/athar_kurd.php">Athar Kurd</a></li>
    <li><a href="/en/jins/bayati.php">Bayati</a></li>
    <li><a href="/en/jins/hijaz.php">Hijaz</a></li>
    <li><a href="/en/jins/hijaz_murassaa.php">Hijaz Murassa‘</a></li>
    <li><a href="/en/jins/hijazkar.php">Hijazkar</a></li>
    <li><a href="/en/jins/jiharkah.php">Jiharkah</a></li>
    <li><a href="/en/jins/kurd.php">Kurd</a></li>
    <li><a href="/en/jins/lami.php">Lami</a></li>
    <li><a href="/en/jins/mukhalif_sharqi.php">Mukhalif Sharqi</a></li>
    <li><a href="/en/jins/mustaar.php">Musta‘ar</a></li>
    <li><a href="/en/jins/nahawand.php">Nahawand</a></li>
    <li><a href="/en/jins/nahawand_murassaa.php">Nahawand Murassa‘</a></li>
    <li><a href="/en/jins/nikriz.php">Nikriz</a></li>
    <li><a href="/en/jins/rast.php">Rast</a></li>
    <li><a href="/en/jins/saba.php">Saba</a></li>
    <li><a href="/en/jins/saba_dalanshin.php">Saba Dalanshin</a></li>
    <li><a href="/en/jins/saba_zamzam.php">Saba Zamzam</a></li>
    <li><a href="/en/jins/sazkar.php">Sazkar</a></li>
    <li><a href="/en/jins/sikah.php">Sikah</a></li>
    <li><a href="/en/jins/sikah_baladi.php">Sikah Baladi</a></li>
    <li><a href="/en/jins/upper_ajam.php">Upper ‘Ajam</a></li>
    <li><a href="/en/jins/upper_rast.php">Upper Rast</a></li>
</ul>
                </div>
                <div class="col-md-9 col-sm-9">

                    <div class="heading jins text-center">
                        <h1>Jins ‘Ajam</h1>
                        <h3>Root jins of the <a href="../maqam/f_ajam.php">Maqam ‘Ajam Family</a></h3>
                    </div>
                    <a href="#" class="show-side-menu d-block d-md-none btn btn-primary"><i class="fa fa-fw fa-bars"></i> Jins Index</a>
                    <div class="clearfix"></div>

                    <div class="text-center mt-2 mb-3">
                        <a href="#" class="pronunciation btn btn-default" data-audio="/audio/name/ajam.mp3"><i class="fa fa-fw fa-volume-up"></i> Pronunciation of ‘Ajam</a>
                    </div>

                    <p>Jins ‘Ajam has two versions:
                    </p>
                    <p><strong>The 5-note version</strong> of Jins ‘Ajam is the most common version, and is the first <em>jins</em> in <a href="../maqam/ajam.php">Maqam ‘Ajam</a> and <a href="../maqam/shawq_afza.php">Maqam Shawq Afza</a>. It is notated here with its tonic on C and its <em>ghammaz</em> on G.
                    </p>

                    <div class="notation" id="notation1">
                        <img src="/note/jins/ajam.png" class="img-fluid" usemap="#notemap">
                        <div class="shape"></div>
                        <p class="clicknotes">Click the notes and hold using the mouse to hear them play.</p>
                    </div>

                    <map name="notemap">
					  <area shape="circle" coords="49,119,12" href="#" alt="A3" class="playNote" data-frequency="220" data-parent="#notation1">
					  <area shape="circle" coords="126,111,12" href="#" alt="B3" class="playNote" data-frequency="247.5" data-parent="#notation1">
					  <area shape="circle" coords="209,103,14" href="#" alt="C4" class="playNote" data-frequency="260.74" data-parent="#notation1">
					  <area shape="circle" coords="283,95,13" href="#" alt="D4" class="playNote" data-frequency="293.33" data-parent="#notation1">
					  <area shape="circle" coords="362,86,13" href="#" alt="E4" class="playNote" data-frequency="328" data-parent="#notation1"><!--variable, tuned down from 330-->
					  <area shape="circle" coords="439,78,13" href="#" alt="F4" class="playNote" data-frequency="347.65" data-parent="#notation1">
					  <area shape="circle" coords="518,70,14" href="#" alt="G4" class="playNote" data-frequency="391.11" data-parent="#notation1">
					  <area shape="circle" coords="590,62,12" href="#" alt="A4" class="playNote" data-frequency="440" data-parent="#notation1">
					</map>

                    <p><strong>The 3-note version</strong> of Jins ‘Ajam occurs mostly when it is used as a secondary <em>jins</em>, for example on the 6<sup>th</sup> scale degree of <a href="../maqam/Bayati.php">Maqam Bayati</a>, <a href="../maqam/Saba.php">Maqam Saba</a> or <a href="../maqam/Kurd.php">Maqam Kurd</a>. This version is a carry over from <a href="../maqam/ajam_ushayran.php">Maqam ‘Ajam ‘Ushayran</a>. It is notated here with its tonic on B&#x266d;.
                    </p>

                    <div class="notation" id="notation2">
                        <img src="/note/jins/ajam-3-note.png" class="img-fluid" usemap="#notemap2">
                        <div class="shape"></div>
                        <p class="clicknotes">Click the notes and hold using the mouse to hear them play.</p>
                    </div>

                    <!-- Copy this bit -->
                    <map name="notemap2">
					  <area shape="circle" coords="37,69,12"  href="#" alt="G4" class="playNote" data-frequency="391.11" data-parent="#notation2">
					  <area shape="circle" coords="114,60,12" href="#" alt="A4" class="playNote" data-frequency="440" data-parent="#notation2">
					  <area shape="circle" coords="196,53,14" href="#" alt="B4♭" class="playNote" data-frequency="463.54" data-parent="#notation2">
					  <area shape="circle" coords="270,45,13" href="#" alt="C5" class="playNote" data-frequency="521.48" data-parent="#notation2">
					  <area shape="circle" coords="347,37,14" href="#" alt="D5" class="playNote" data-frequency="586.66" data-parent="#notation2">
					  <area shape="circle" coords="420,29,12" href="#" alt="E5♭" class="playNote" data-frequency="616.50" data-parent="#notation2">
					  <area shape="circle" coords="496,21,12" href="#" alt="F5" class="playNote" data-frequency="695.31" data-parent="#notation2">
					</map>

                    <div class="player-area">
                        <audio id="player" controls>
                            <source src="/audio/jins/ajam/aghadan_alqak.mp3" type="audio/mp3">
                        </audio>
                    </div>

                    <br>
                    <div class="heading jins text-center">
                        <h3>Jins ‘Ajam 5-note version examples</h3>
                    </div>
                    <div class="clearfix"></div>
                    <br>

                    <div class="track" data-song="/audio/jins/ajam/aghadan_alqak.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Aghadan Alqaka (1971)</b>
                                    <span>Umm Kulthum</span>
                                    <span>Music by Muhammad Abdel Wahab (Egypt)</span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="track" data-song="/audio/jins/ajam/el_bwab.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>el-Buwab (1994)</b>
                                    <span>Fairouz</span>
                                    <span>Music by Philemon Wehbe</span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="track" data-song="/audio/jins/ajam/fi_youm_we_leila.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Fi Youm we Leila (1978)</b>
                                    <span>Warda</span>
                                    <span>Music by Muhammad Abdel Wahab (Egypt)</span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="track" data-song="/audio/jins/ajam/lissa_fakir.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Lissa Fakir (1960)</b>
                                    <span>Umm Kulthum</span>
                                    <span>Music by Riyad al-Sunbati</span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="track" data-song="/audio/jins/ajam/min_youm_furgak.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Mawwal Min Youm Furgak</b>
                                    <span>Muhammad Khayri</span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="track" data-song="/audio/jins/ajam/til3it_ya_mahla_nurha.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Til‘it Ya Mahla Nurha</b>
                                    <span>Muhammad Abdel Karim</span>
                                    <span>Music by Sayed Darwish</span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <br>
                    <div class="heading jins text-center">
                        <h3>Jins ‘Ajam 3-note version examples</h3>
                    </div>
                    <div class="clearfix"></div>
                    <br>

                    <div class="track" data-song="/audio/jins/ajam-3note/ba3id-3annak.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Ba‘id ‘Annak (1965)</b>
                                    <span>Umm Kulthum</span>
                                    <span>Music by Baligh Hamdi (Egypt)</span>
                                    <span>3-note Jins ‘Ajam on the 6<sup>th</sup> degree of <a href="../maqam/kurd.php">Maqam Bayati</a></span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="track" data-song="/audio/jins/ajam-3note/habba-fou2.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Habba Fouq w Habba Taht</b>
                                    <span>Ahmad Adaweya</span>
                                    <span>Music by Mohamed el-Mesery</span>
                                    <span>3-note Jins ‘Ajam on the 6<sup>th</sup> degree of <a href="../maqam/saba.php">Maqam Saba</a></span>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="track" data-song="/audio/jins/ajam-3note/ahu-dalli-sar.mp3">
                        <div class="radio">
                            <label>
                                <input type="radio" name="song" value="1">
                                <div class="info">
                                    <b>Ahu Da-lli Sar</b>
                                    <span>Nay Barghouthi</span>
                                    <span>Music by Sayed Darwish</span>
                                    <span>3-note Jins ‘Ajam on the 6<sup>th</sup> degree of <a href="../maqam/kurd.php">Maqam Kurd</a></span>
                                </div>
                            </label>
                        </div>
                    </div>
                    
                </div>
                <div class="col-sm-12">
                    <div class="text-center ad-leaderboard">
    <div class="d-none d-lg-block m-auto">
        <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        <!-- horizontal_banner_728x90 -->
        <ins class="adsbygoogle"
        style="display:inline-block;width:728px;height:90px"
        data-ad-client="ca-pub-5273721442342622"
        data-ad-slot="1062056659"></ins>
        <script>
        (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
    </div>
    <div class="d-sm-none m-auto">
        <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        <!-- Large Mobile Banner 320x100 -->
        <ins class="adsbygoogle"
        style="display:inline-block;width:320px;height:100px"
        data-ad-client="ca-pub-5273721442342622"
        data-ad-slot="1017192100"></ins>
        <script>
        (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
    </div>
</div>                </div>
            </div>
        </div>
    </div>

    <footer>
    <div class="container">
        <div class="row">
            <div class="col-sm-4"> <img src="/img/logo-bottom.png" height="30" class="footer-logo">
                <p>&copy; 2001-2018 MaqamWorld
                <br>All rights reserved.
                <br>Concept, content and design: <a href="https://www.amazon.com/Johnny-Farraj/e/B07SD841D2" target="_blank">Johnny Farraj</a>
                <br>Web development and coding: <a href="http://filiptodorov.com" target="_blank">Filip Todorov</a>
                </p>
                <!--
                <ul class="socials">
                    <li><a href="#"><i class="fa fa-fw fa-facebook"></i></a></li>
                    <li><a href="#"><i class="fa fa-fw fa-youtube"></i></a></li>
                </ul>
                -->
            </div>
            <div class="col-sm-3">
                <h3>Contact Us</h3>
                <ul class="menu">
                    <!--
                    <li><a href="#"><i class="fa fa-fw fa-phone"></i> Call Us</a></li>
                    <li><a href="#"><i class="fa fa-fw fa-map-marker"></i> Visit Us</a></li>
                    -->
                    <li><a href="/en/contact.php"><i class="fa fa-fw fa-envelope"></i> Send us a message</a></li>
                </ul>
            </div>
            <div class="col-sm-5 text-right">
                <a href="https://www.arabculturefund.org" target="_blank"><img src="/img/afac_en.png" class="afac"></a>
            </div>
        </div>
    </div>
</footer>    <!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/js/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/plyr.min.js"></script>
<script src="/js/plyr.polyfilled.min.js"></script>
<script src="/js/owl.carousel.min.js"></script>
<script src="/js/custom.js?v=1.1"></script>
<script>
    $(document).ready(function() {
        var currentPage = "en/jins/ajam.php";
        if(currentPage) {
            if($("a:regex(href, .*" + currentPage + "$)").parents(".sub-menu")) {
                $("a:regex(href, .*" + currentPage + "$)").parents("li").addClass("active");
            }
        }
    })
</script>
  </body>
</html>