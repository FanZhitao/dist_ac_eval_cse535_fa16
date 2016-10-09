
src/master.py: src/master.da src/client.py src/msg/request.py src/msg/response.py src/util/router.py
	dac src/master.da

src/client.py: src/client.da src/comp/coordinator.py src/msg/request.py src/msg/response.py src/util/router.py
	dac src/client.da

src/comp/coordinator.py: src/comp/coordinator.da src/comp/worker.py src/msg/request.py src/msg/response.py src/util/router.py src/util/admin.py src/util/idgen.py
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

src/util/admin.py: src/util/admin.da
	dac src/util/admin.da

src/util/idgen.py: src/util/idgen.da
	dac src/util/idgen.da

clean:
	rm -rf src/*.py src/**/*.py src/__pycache__ src/**/__pycache__
