#ifndef RING_H
#define RING_H
#include <malloc>
class Ring
{
private:
    int elemSize;
    int size;
    int maxSize;
    int idx;
    vector<void*> ring;

public:
    Ring(int objSize)
    {
        this.maxSize = -1;
        this.idx = 0;
        this.size = objSize;
        this.ring = vector<void*>();
    }
    Ring(int objSize, int maxSize)
    {
        Ring(objSize);
        this.maxSize = maxSize;
    }
    ~Ring()
    {
        if(ring != NULL)
        {
            free(ring);
        }
    }
    int push(void* object);
    int push(std::vector<void*> objects);
    int pop(void* object);
    int pop(std::vector<void*> &objects);
    void clear();
    bool isEmpty();
    bool isFull();
    int getSize();
};

#endif
