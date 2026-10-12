/// An appointment ends on the day it starts: 23:59 at the latest. One that
/// runs to midnight or past it is refused by the server.
bool endsOnStartDay(DateTime start, DateTime end) =>
    end.year == start.year && end.month == start.month && end.day == start.day;
