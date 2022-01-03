# acrostic

acrostic.

![img](acrostic)


# Requirements

- norns

# Documentation


## installation

requires latest softcut and a unrelease norns build.

first rebuild norns:

```bash
cd ~; ~/norns/stop.sh; rm -rf ~/norns; \
git clone git@github.com:schollz/norns && \
cd ~/norns && git checkout sc-rec-once && \
git submodule update --init --recursive && \
cd ~/norns/crone/softcut && \
git checkout main && \
cd ~/norns/crone/softcut/softcut-lib && \
./waf configure && \
./waf && \
cd ~/norns && \
./waf configure --enable-ableton-link && \
./waf build
```

then install acrostic:

```bash
rm -rf ~/dust/code/acrostic && \
git clone https://github.com/schollz/acrostic ~/dust/code/acrostic && \
cd ~/dust/code/acrostic && git checkout beta
```

then restart norns:

```bash
sudo systemctl restart norns-jack.service; \
sudo systemctl restart norns-matron.service; \
sudo systemctl restart norns-crone.service
```

## quick start

1. plug in a midi device or cv pitch to crow 1.
2. start script, wait for the ghost's eyes to open.
3. press K1+K3.


## sequencer

- K1+E1 changes page
- K1 shifts
- E1 changes context

### chord context

- E2 or K1+E2 select chord position
- E3 change chord
- K1+K3 change beats of chord
- K2 transpose chords
- K3 start/stop

### note/phrase context

- E2 select notes in chord
- E3 select phrase
- K1+E2 rotate notes in chord
- K1+E3 rotate phrase
- K2/K3 lower/raise octave of currently selected
- K1+K3 reset octaves of currently selected

### sampling context

- E2 select sample
- K3 queues recording
- K3 dequeues recording
- K1+K2 erase recording
- K1+K3 queue unrecorded samples
- E3 change level
- K1+E2 changes pre
- K1+E3 chagnes rec

## the ghost

???????

## Install

install with

```
;install https://github.com/schollz/acrostic
```