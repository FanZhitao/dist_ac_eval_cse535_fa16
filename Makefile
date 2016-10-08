
src/master.py: src/master.da src/client.py src/msg/request.py src/msg/response.py src/util/router.py
	dac src/master.da

src/client.py: src/client.da src/comp/coordinator.py src/msg/request.py src/msg/response.py src/util/router.py
	dac src/client.da

src/comp/coordinator.py: src/comp/coordinator.da src/comp/worker.py src/msg/request.py src/msg/response.py
	dac src/comp/coordinator.da

src/comp/worker.py: src/comp/worker.da src/db/db.py src/msg/request.py src/msg/response.py
	dac src/comp/worker.da

src/db/db.py: src/db/db.da
	dac src/db/db.da

src/msg/request.py: src/msg/request.da
	dac src/msg/request.da

src/msg/response.py: src/msg/response.da
	dac src/msg/response.da

src/util/router.py: src/util/router.da
	dac src/util/router.da

clean:
	rm -rf src/*.py src/**/*.py src/__pycache__ src/**/__pycache__
