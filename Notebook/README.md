## build notebook

	docker build -t alexwoo/notebook ./

## run notebook

	docker run --rm -p 8888:8888 -v /path/to/save/your/data:/home/notebook/work alexwoo/notebook

If you want data Persistence, use -v to map /home/notebook/work/ outside

## login

use [http://127.0.0.1:8888](http://127.0.0.1:8888) to login, token is given when notebook start successd. the info is as below:

	[C 20:19:39.999 NotebookApp]

	    Copy/paste this URL into your browser when you connect for the first time,
	    to login with a token:
	        http://(051f2060b4a8 or 127.0.0.1):8888/?token=378fcee2db23e1a77509840251688875d2d7181dc3e5510f
