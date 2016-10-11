
src/master.py: src/master.da src/client.py src/msg/request.py src/msg/response.py src/util/router.py
	dac src/master.da

src/client.py: src/client.da src/comp/coordinator.py src/msg/request.py src/msg/response.py src/util/router.py
	dac src/client.da

src/comp/coordinator.py: src/comp/coordinator.da src/comp/worker.py src/msg/evalreq.py src/msg/evalresp.py src/msg/commitreq.py src/msg/commitresp.py src/util/router.py src/util/idgen.py src/state/admin.py 
	dac src/comp/coordinator.da

src/comp/worker.py: src/comp/worker.da src/db/db.py src/msg/request.py src/msg/response.py
	dac src/comp/worker.da

src/db/db.py: src/db/db.da
	dac src/db/db.da

src/state/admin.py: src/state/admin.da src/state/cache.py src/state/statemac.py
	dac src/state/admin.da

src/state/cache.py: src/state/cache.da
	dac src/state/cache.da

src/state/statemac.py: src/state/statemac.da
	dac src/state/statemac.da

src/msg/evalreq.py: src/msg/evalreq.da src/msg/request.py
	dac src/msg/evalreq.da

src/msg/evalresp.py: src/msg/evalresp.da src/msg/response.py
	dac src/msg/evalresp.da

src/msg/commitreq.py: src/msg/commitreq.da src/msg/request.py
	dac src/msg/commitreq.da

src/msg/commitresp.py: src/msg/commitresp.da src/msg/request.py
	dac src/msg/commitresp.da

src/msg/request.py: src/msg/request.da
	dac src/msg/request.da

src/msg/response.py: src/msg/response.da
	dac src/msg/response.da

src/util/router.py: src/util/router.da
	dac src/util/router.da

src/util/idgen.py: src/util/idgen.da
	dac src/util/idgen.da

clean:
	rm -rf src/*.py src/**/*.py src/__pycache__ src/**/__pycache__
