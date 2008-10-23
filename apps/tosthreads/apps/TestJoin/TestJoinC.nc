/*
 * Copyright (c) 2008 Stanford University.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Stanford University nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL STANFORD
 * UNIVERSITY OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
/**
 * @author Kevin Klues (klueska@cs.stanford.edu)
 */

module TestJoinC {
  uses {
    interface Boot;
    interface Thread as NullThread;
    interface Thread as TinyThread0;
    interface Thread as TinyThread1;
    interface Thread as TinyThread2;
    interface Leds;
  }
}

implementation {
  event void Boot.booted() {
    call NullThread.start(NULL);
  }

  event void NullThread.run(void* arg) {
    for(;;){
      call TinyThread0.start(NULL);
      call TinyThread1.start(NULL);
      call TinyThread2.start(NULL);
      call TinyThread1.join();
      call TinyThread0.join();
      call TinyThread2.join();
    }
  }  
  event void TinyThread0.run(void* arg) {
    int i;
    for(i=0; i<2; i++){
      call Leds.led0Toggle();
      call TinyThread0.sleep(1000);
    }
  }
  event void TinyThread1.run(void* arg) {
    int i;
    for(i=0; i<4; i++){ 
      call Leds.led1Toggle();
      call TinyThread1.sleep(1000);
    }
  }
  event void TinyThread2.run(void* arg) {
    int i;
    for(i=0; i<6; i++){
      call Leds.led2Toggle();
      call TinyThread2.sleep(1000);
    }
  }
}