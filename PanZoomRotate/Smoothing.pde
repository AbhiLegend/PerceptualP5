// Ratko Jagodic
// 
// How to use:
// Smooth sm = new Smooth();
// myVal = sm.smoothValue(myVal);
//


class Smooth
{
  int SMOOTHING = 4;  // higher number, more smoothing but more latency...
  int smoothingIndex = 0, smoothingVectorIndex = 0;
  float[] smoothingBuffer;
  PVector[] smoothingVectorBuffer;

        float INF = 1e9;

  public Smooth(int smoothAmt)
  {
    SMOOTHING = smoothAmt;
    smoothingBuffer = new float[SMOOTHING];
    smoothingVectorBuffer = new PVector[SMOOTHING];
    
    // initialize the smoothing buffer
    clear();
  }
  
  public Smooth()
  {
    this(4);
  }

        public void clear()
        {
                // initialize the smoothing buffer
                for(int i=0; i<SMOOTHING; i++)
                {
                        smoothingBuffer[i] = INF;
                        smoothingVectorBuffer[i] = new PVector(INF, INF, INF);
                }  
        }
  
  float smoothValue(float newVal)
  {
    smoothingBuffer[smoothingIndex] = newVal;
    smoothingIndex++;
    if (smoothingIndex >= SMOOTHING)
      smoothingIndex = 0;
    
    // return average
    float tot = 0;
    int c=0;
    for(int i=0; i<SMOOTHING; i++)
    {
                        if(smoothingBuffer[i] != INF)
                        {
        tot += smoothingBuffer[i];
        c++;
                        }
    }
    return tot/c;
  }


  PVector smoothVector(PVector newVal)
  {
    smoothingVectorBuffer[smoothingVectorIndex] = newVal;
    smoothingVectorIndex++;
    if (smoothingVectorIndex >= SMOOTHING)
      smoothingVectorIndex = 0;
    
    // return average
    PVector total = new PVector(0,0,0);
    PVector ave = new PVector(0,0,0);
    
    int c = 0;
    for(int i=0; i<SMOOTHING; i++)
    {
      if(smoothingVectorBuffer[i].x != INF)
      {
        total.x += smoothingVectorBuffer[i].x;
        total.y += smoothingVectorBuffer[i].y;
        total.z += smoothingVectorBuffer[i].z;  
        c++;
      }
    }
    
    ave.x = total.x/c;
    ave.y = total.y/c;
    ave.z = total.z/c;
    
    return ave;
  }

}
