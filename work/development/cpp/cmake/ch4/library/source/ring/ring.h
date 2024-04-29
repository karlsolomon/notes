#ifndef RING_H
#define RING_H
#include <vector>
class Ring {
private:
  int elemSize;
  int size;
  int maxSize;
  int idx;
  std::vector<void*> ring;

public:
  Ring(int objSize);
  Ring(int objSize, int maxSize);
  ~Ring();

  int push(void *object);
  int push(std::vector<void *> objects);
  int pop(void *object);
  int pop(std::vector<void *> &objects);
  void clear();
  bool isEmpty();
  bool isFull();
  int getSize();
};

#endif
