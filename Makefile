
src/master.py: src/master.da src/client.py src/msg/request.py src/msg/response.py
	dac src/master.da

src/client.py: src/client.da src/comp/sc.py src/msg/request.py src/msg/response.py
	dac src/client.da

src/comp/sc.py: src/comp/sc.da src/comp/rc.py src/msg/request.py src/msg/response.py
	dac src/comp/sc.da

src/comp/rc.py: src/comp/rc.da src/comp/worker.py src/msg/request.py src/msg/response.py
	dac src/comp/rc.da

src/comp/worker.py: src/comp/worker.da src/db/db.py src/msg/request.py src/msg/response.py
	dac src/comp/worker.da

src/db/db.py: src/db/db.da
	dac src/db/db.da

src/msg/request.py: src/msg/request.da
	dac src/msg/request.da

src/msg/response.py: src/msg/response.da
	dac src/msg/response.da

clean:
	rm -rf src/*.py src/**/*.py src/__pycache__ src/**/__pycache__
