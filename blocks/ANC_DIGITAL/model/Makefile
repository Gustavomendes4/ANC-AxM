CFLAGS=-Wall -Iinclude
WAVFILE=../wav/airplaneinterior.wav

out/sim: main.cpp
	mkdir -p out
	g++ main.cpp $(CFLAGS) -o out/sim

run: out/sim
	./out/sim $(WAVFILE)

clean:
	rm -rf out
.PHONY: run clean
