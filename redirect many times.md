(1)comment schemes in app/config/routing_prod.yml file

ex. 
```
_main:
    resource: routing.yml
#    schemes: [http]

_main_custom:
    resource: project/routing_custom.yml
#    schemes: [http]
```
(2)add belllow line in web/app.php file 
`
Request::setTrustedProxies(array('127.0.0.1', $request->server->get('REMOTE_ADDR')));
`
ex.
```
$kernel = new AppKernel('prod', false);
$kernel->loadClassCache();
//$kernel = new AppCache($kernel);
$request = Request::createFromGlobals();
Request::setTrustedProxies(array('127.0.0.1', $request->server->get('REMOTE_ADDR')));
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
```
(3)add belllow line in web/app_dev.php file
`
Request::setTrustedProxies(array('127.0.0.1', $request->server->get('REMOTE_ADDR')));
`
ex.
```
$kernel = new AppKernel('prod', false);
$kernel->loadClassCache();
//$kernel = new AppCache($kernel);
$request = Request::createFromGlobals();
Request::setTrustedProxies(array('127.0.0.1', $request->server->get('REMOTE_ADDR')));
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
```
