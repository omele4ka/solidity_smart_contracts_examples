/* создать смарт-контракт, который позволяет пользователям
создавать, просматривать и бронировать места на различные события (концерты,
конференции, мастер-классы и т. д.) */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventContract {
    address public owner;
    uint public eventCount;
    mapping (uint => Event) public events;

    struct Event {
        string name;
        uint dateTime;
        uint ticketPrice;
        uint totalSeats;
        uint availableSeats;
        address[] attendees;
        mapping (address => bool) hasAttended;
    }

    constructor() {
        owner = msg.sender;
        eventCount = 0;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function createEvent(string memory name, uint dateTime, uint ticketPrice, uint totalSeats) 
    public onlyOwner {
        Event storage newEvent = events[eventCount];
        newEvent.name = name;
        newEvent.dateTime = dateTime;
        newEvent.ticketPrice = ticketPrice;
        newEvent.totalSeats = totalSeats;
        newEvent.availableSeats = totalSeats;
        eventCount++;
    }

    function getEvent(uint eventId) public view returns (string memory, uint, uint, uint, uint) {
        Event storage myEvent = events[eventId];
        return (myEvent.name, myEvent.dateTime, myEvent.ticketPrice, myEvent.totalSeats, myEvent.availableSeats);
    }

    function bookTicket(uint eventId) public payable {
        require(eventId < eventCount, "Invalid event ID");
        Event storage selectedEvent = events[eventId];
        require(selectedEvent.availableSeats > 0, "No seats available");
        selectedEvent.attendees.push(msg.sender);
        selectedEvent.availableSeats--;
    }

    function cancelEvent (uint eventId) public onlyOwner {
        require(eventId < eventCount, "Invalid event ID");
        Event storage selectedEvent = events[eventId];
        selectedEvent.availableSeats = 0;
    }

    function refundTicket(uint eventId, address attendee) public onlyOwner {
        require(eventId < eventCount, "Invalid event ID");
        Event storage selectedEvent = events[eventId];
        require(selectedEvent.hasAttended[attendee] == false, "Attendee has already attended");

        for (uint i = 0; i < selectedEvent.attendees.length; i++) {
            if (selectedEvent.attendees[i] == attendee) {
                selectedEvent.attendees[i] = selectedEvent.attendees[selectedEvent.attendees.length - 1];
                selectedEvent.attendees.pop();
                selectedEvent.availableSeats++;
                break;
            }
        }
    }
}