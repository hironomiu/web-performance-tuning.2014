<?php
require_once __DIR__ . '/../app/bootstrap.php';
require_once __DIR__ . '/../app/setup.php';

require_once __DIR__ . '/../app/chapter1.php';
require_once __DIR__ . '/../app/chapter2.php';
require_once __DIR__ . '/../app/chapter3.php';

require_once __DIR__ . '/../app/exercise.php';

$app->get('/',function() use($app) {
    return $app['twig']->render('index.twig');
});

$app->get('/info',function() use($app) {
    return phpinfo();
});

$app->run();
