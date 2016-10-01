
src/master.py: src/client.py
	dac src/master.da

src/client.py: src/sc.py
	dac src/client.da

src/sc.py: src/rc.py
	dac src/sc.da

src/rc.py: src/worker.py
	dac src/rc.da

src/worker.py: src/db.py
	dac src/worker.da

src/db.py:
	dac src/db.da

clean:
	rm -rf src/*.py src/__pycache__
