# 前提
- 下記ミドルウェアが利用可能なこと
MySQL
Memcached

# 構築
```
$ make install
```

# セットアップ
app/config.phpにDB接続(MySQL,Memcached)の設定をすること
```
$ cp app/config.php.template app/config.php
$ vi app/config.php
```

# 起動
- BuiltInServerの起動
任意のHOST、PORTを指定して起動
```
$ HOST=xxx.xxx.xxx.xxx PORT=xxxx make server
```
