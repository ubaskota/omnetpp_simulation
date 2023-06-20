//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package sampleplay;


simple Node {
//module Node {
    parameters:
//        bool sendMsgOnInit = default(false);
//         int limit = default(2);
        @display("i=block/routing");
        double cpuClock = 500;
        double memsize = 512;
        int numCores = 1;
        int processing_time @unit(s);
        int delayTime = default(2);
        
		gates:
//        input in;
//        output out;
		inout gate[];
       
}
	    





//simple Node1 extends Node {
//    parameters:
//        sendMsgOnInit = true;
//}
//
//
//simple Node2 extends Node {
//    parameters:
//         sendMsgOnInit = false;
//}
//
//
//simple Node3 extends Node {
//    parameters:
//         sendMsgOnInit = false;
//}
//
//
//simple Node4 extends Node {
//    parameters:
//         sendMsgOnInit = false;
//}


network SampleConnection {
    types:
        channel Channel extends ned.DelayChannel {
            delay = 100ms;
        }
    
    submodules:
//        node1: Node1;
//        node2: Node2;
//        node3: Node3;
//        node4: Node4;
		node[8]: Node;


    connections: 
//        node1.out --> {  delay = 100ms; } --> node2.in;
////        node1.in <-- {  delay = 100ms;  } <-- node2.out;
//		node3.in <-- {  delay = 100ms;  } <-- node2.out;
//		node3.out --> { delay = 100ms; } --> node4.in;
//		node4.out -->  { delay = 100ms; } --> node1.in;

		//This is a working model
//		node[0].gate++ <--> Channel <--> node[1].gate++;
//		node[0].gate++ <--> Channel <--> node[2].gate++;
//		node[0].gate++ <--> Channel <--> node[3].gate++;
//		node[0].gate++ <--> Channel <--> node[4].gate++;
//		node[0].gate++ <--> Channel <--> node[5].gate++;
//		node[0].gate++ <--> Channel <--> node[6].gate++;
//		
		node[0].gate++ <--> Channel <--> node[1].gate++;
		node[1].gate++ <--> Channel <--> node[2].gate++;
		node[1].gate++ <--> Channel <--> node[3].gate++;
		node[1].gate++ <--> Channel <--> node[4].gate++;
		node[1].gate++ <--> Channel <--> node[5].gate++;
		node[1].gate++ <--> Channel <--> node[6].gate++;
		node[1].gate++ <--> Channel <--> node[7].gate++;
		
		
//		node[1].gate++ <--> Channel <--> node[2].gate++;
//		node[1].gate++ <--> Channel <--> node[3].gate++;
//		node[1].gate++ <--> Channel <--> node[4].gate++;
//		node[1].gate++ <--> Channel <--> node[5].gate++;
//		node[1].gate++ <--> Channel <--> node[6].gate++;
//		
//		node[2].gate++ <--> Channel <--> node[3].gate++;
//		node[2].gate++ <--> Channel <--> node[4].gate++;
//		node[2].gate++ <--> Channel <--> node[5].gate++;
//		node[2].gate++ <--> Channel <--> node[6].gate++;
//		
//		node[3].gate++ <--> Channel <--> node[4].gate++;
//		node[3].gate++ <--> Channel <--> node[5].gate++;
//		node[3].gate++ <--> Channel <--> node[6].gate++;
//		
//		node[4].gate++ <--> Channel <--> node[5].gate++;
//		node[4].gate++ <--> Channel <--> node[6].gate++;

}

