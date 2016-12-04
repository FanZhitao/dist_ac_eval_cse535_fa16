
src/master.py: src/master.da src/comp/application.py src/comp/coordinator.py src/comp/coordinatormvcc.py src/msg/request.py src/msg/response.py src/util/router.py
	dac src/master.da

src/comp/application.py: src/comp/application.da src/msg/request.py src/msg/response.py src/util/router.py src/util/analyzer.py
	dac src/comp/application.da

src/comp/coordinator.py: src/comp/coordinator.da src/comp/worker.py src/msg/evalreq.py src/msg/evalresp.py src/msg/commitreq.py src/msg/commitresp.py src/util/router.py src/util/idgen.py src/state/admin.py src/util/dynanalyzer.py
	dac src/comp/coordinator.da
src/comp/coordinatormvcc.py: src/comp/coordinatormvcc.da src/comp/workermvcc.py src/msg/evalreqmvcc.py src/msg/evalrespmvcc.py src/util/router.py src/util/idgen.py src/state/adminmvcc.py 
	dac src/comp/coordinatormvcc.da

src/comp/worker.py: src/comp/worker.da src/db/db.py src/msg/request.py src/msg/response.py
	dac src/comp/worker.da
src/comp/workermvcc.py: src/comp/workermvcc.da src/db/db.py src/msg/request.py src/msg/response.py
	dac src/comp/workermvcc.da

src/db/db.py: src/db/db.da
	dac src/db/db.da

src/state/admin.py: src/state/admin.da src/state/cache.py src/state/statemac.py
	dac src/state/admin.da
src/state/adminmvcc.py: src/state/adminmvcc.da
	dac src/state/adminmvcc.da

src/state/cache.py: src/state/cache.da
	dac src/state/cache.da

src/state/statemac.py: src/state/statemac.da
	dac src/state/statemac.da

src/msg/evalreq.py: src/msg/evalreq.da src/msg/request.py
	dac src/msg/evalreq.da
src/msg/evalreqmvcc.py: src/msg/evalreqmvcc.da src/msg/request.py
	dac src/msg/evalreqmvcc.da

src/msg/evalresp.py: src/msg/evalresp.da src/msg/response.py
	dac src/msg/evalresp.da
src/msg/evalrespmvcc.py: src/msg/evalrespmvcc.da src/msg/response.py
	dac src/msg/evalrespmvcc.da

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

src/util/analyzer.py: src/util/analyzer.da
	dac src/util/analyzer.da
src/util/dynanalyzer.py: src/util/dynanalyzer.da
	dac src/util/dynanalyzer.da

clean:
	rm -rf src/*.py src/**/*.py src/__pycache__ src/**/__pycache__
