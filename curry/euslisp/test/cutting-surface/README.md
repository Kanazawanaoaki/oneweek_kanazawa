# surface test
surface test.  

## without rec
codes without recognition.

### potato
progaram for potato.

#### potato-move
grasp and move potato.
```
rlwrap roseus potato-move.l

(set-potato :w width :l length :h height)
(move-potato)
(finish)
```
also exec `(now-devel)` and `(now-test)`.  

#### potato-surface-proto
cut and peel potato first set.  
```
rlwrap roseus potato-surface-proto.l

(set-potato :w width :l length :h height)
(grasp-potato)
(set-knife-hor)
(cut-test3)

(change-peeler)
(peel-test)
(finish-pose)

(put-potato)
(next-grasp)
(set-peel)

(next-set)

(peel-test2)
(finish)
```
also exec `(now-test)` and `(exec-all)`.  

#### potato-rotate
grasp and rotate potato.
```
rlwrap roseus potato-rotate.l

(set-potato :w width :l length :h height)
(move-potato-1)

(rotate-potato)
(finish)
```
also exec `(now-devel)` and `(now-test)`.  

#### potato-surface-second
cut and peel potato second set.
```
rlwrap roseus potato-surface-second.l

(set-potato :w width :l length :h height)
(move-potato-1)
(grasp-potato-second)

(set-knife-hor)
(cut-test3-second)

(change-peeler-second)
(peel-test)
(finish-pose)

(put-potato-second)
(next-grasp-second)
(set-peel)

(next-set)

(peel-test2)  
(finish)
```
also exec `(now-test)` and `(exec-all)`.  

### carrot
progaram for carrot.  

#### carrot-move
grasp and move carrot.
```
rlwrap roseus carrot-move.l

(set-carrot :w width :l length :h height)
(move-carrot)

(finish)
```
also exec `(now-devel)` and `(now-test)`.  

#### carrot-surface-proto
cut and peel carrot first set.  
```
rlwrap roseus carrot-surface-proto.l

(set-carrot :w width :l length :h height)
(grasp-carrot)
(set-knife-hor)
(cut-test3)

(change-peeler)
(peel-pose)
(peel-carrot-test)
(finish-pose)

(put-carrot)
(next-grasp)
(set-peel)

(next-set)

(peel-test2)
(finish)
```
also exec `(now-test)` and `(exec-all)`.  

#### carrot-rotate
grasp and move carrot for second set.
```
(set-carrot :w width :l length :h height)
(move-carrot-1)

(move-carrot)

(finish)
```
also exec `(now-devel)` and `(now-test)`.  

#### carrot-surface-second
cut and peel carrot second set.
```
(set-carrot :w width :l length :h height)
(move-carrot-1)
(grasp-carrot-second)
(set-knife-hor)
(cut-test3-second)

(change-peeler-second)
(peel-pose)
(peel-carrot-test)
(finish-pose)

(put-carrot-second)
(next-grasp-second)
(set-peel)

(next-set)

(peel-test2)
(finish)
```
also exec `(now-test)` and `(exec-all)`.  
