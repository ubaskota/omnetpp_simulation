#include <stdio.h>
#include <string.h>
#include <omnetpp.h>


#include "txc1_m.h"
//#include "task_m.h"
//#include "TaskGenerator.h"

//Txc1Msg
using namespace omnetpp;

class Node : public cSimpleModule
{
  private:
    // Set the pointers to nullptr, so that the destructor won't crash
    // even if initialize() doesn't get called because of a runtime
    // error or user cancellation during the startup process.
    cMessage *event = nullptr;  // pointer to the event object which we'll use for timing
    cMessage *nodeMsg = nullptr;  // variable to remember the message until we send it back
    int counter;
    int taskId;
    int taskSize;
    int seed = 0;
    bool firstMessageSent = false;
    std::vector<int> recVector;


//  public:
//    virtual ~Node();

  protected:
    virtual Txc1Msg *generateMessage();
    virtual void forwardMessage(Txc1Msg *msg);
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(Node);


void Node::initialize()
{
    // Module 0 sends the first message
    event = new cMessage("event");
    if (getIndex() == 0) {
        // Boot the process scheduling the initial message as a self-message.
//        Txc1Msg *msg = generateMessage();
//        scheduleAt(0.0, msg);
        scheduleAt(0.0, event);
    }
}

void Node::handleMessage(cMessage *msg)
{

    if (msg == event and getIndex() == 0) {
        Txc1Msg *msg = generateMessage();
        simtime_t delay = par("delayTime");
        scheduleAt(simTime()+0.05, event);
        forwardMessage(msg);
    }
    else {
        Txc1Msg *ttmsg = check_and_cast<Txc1Msg *>(msg);
        EV << "Is the message sent once : " << firstMessageSent << " \n ";

//        if (ttmsg->getDestination() == getIndex()) {
        if (firstMessageSent == true){
            // Message arrived.
//            EV << "This is geDestination : " << ttmsg->getDestination() << " , and getIndex : " << getIndex() << " end. \n";
//            EV << "Message " << ttmsg << " arrived after " << ttmsg->getHopCount() << " hops.\n";
            delete ttmsg;
            firstMessageSent = false;

            // Generate another one.
//            EV << "Generating another message: ";
//            Txc1Msg *newmsg = generateMessage();
//            EV << newmsg << endl;
//            forwardMessage(newmsg);
        }
        else {
            // We need to forward the message.
            // We need to forward the message.
            int x = ttmsg->getMyNumber();
            recVector.push_back(x);   // store received number
            forwardMessage(ttmsg);
//            delete ttmsg;
        }
    }
}


Txc1Msg *Node::generateMessage()
{
    // Produce source and destination addresses.
    int src = getIndex();  // our module index
    int n = getVectorSize();  // module vector size
    int dest = intuniform(0, n-2);
    if (dest >= src)
        dest++;

    char msgname[20];
    sprintf(msgname, "tic-%d-to-%d", src, dest);

    // Create message object and set source and destination field.
    Txc1Msg *msg = new Txc1Msg(msgname);
    msg->setSource(src);
    msg->setDestination(dest);
    msg->setMyNumber(intrand(100));  // set random number from 0..99
    return msg;
}

void Node::forwardMessage(Txc1Msg *msg)
{
    // Increment hop count.
    msg->setHopCount(msg->getHopCount()+1);
    seed += 1;

    // Same routing as before: random gate.
    int n = gateSize("gate");
//    int k = intuniform(0, n-1);

//    if (firstMessageSent == true) {   //Node[0] should only send the message
//        n = 8;
//    }

    int k = seed %  n;
    EV << "This is n : " << n << " and this is k : " << k << " and this is seed : " << seed << "\n";

    firstMessageSent = true;


    EV << "Forwarding message " << msg << " on gate[" << k << "]\n";
    send(msg, "gate$o", k);
}




