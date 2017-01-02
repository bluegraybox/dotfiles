#!/usr/bin/python

# Create a time summary for work journal entries.
# Invoked from vi as: 'a,.!summarize-time.py
# Turn this:
#     9:49am ADMIN - status
#         stand-up meeting
#         tasking discussion
#     10:26am IBEW - unit tests
#     12:34am BREAK - lunch
#     1:01pm IBEW - unit tests
#     2:00pm ADMIN - weekly dev meeting
#     2:43pm IBEW - unit tests
#     3:00pm ADMIN - 1-on-1 w/ Jason
#     3:47pm IBEW - data load on db server
#         data load mysteriously exits on syncdb line
#             cron can't send mail
#             only log to file; works fine
#     5:17pm ADMIN - status
#     5:24pm OUT
# Into this:
#     ADMIN - status.  weekly dev meeting.  1-on-1 w/ Jason (:37 :43 :47 = 2:07)
#     IBEW - unit tests.  data load on db server (2:08 :59 :17 1:30 = 4:54)

import sys
import re
from collections import defaultdict

class Task(object):
    def __init__(self):
        self.descriptions = set()
        self.times = []
        self.total = 0


#line_re = re.compile(r"^    (\d+):(\d+)")
#line_re = re.compile(r"\??")
#line_re = re.compile(r" +")
#line_re = re.compile(r"([A-Z]+)")
#line_re = re.compile(r"(?: - )?")
#line_re = re.compile(r"(.*)")
line_re = re.compile(r"^    (\d+):(\d+)([ap]m)\?? +([A-Z]\w+-?[0-9]*)(?: - )?(.*)")
lines = sys.stdin.readlines()
tasks = defaultdict(Task)
last_time = None
last_task = None
for line in lines:
    print line.rstrip()
    m = line_re.search(line)
    if m:
        hours = int(m.group(1))
        minutes = int(m.group(2))
        am_pm = m.group(3)
        if am_pm == 'pm':
            hours += 12
        t = (hours * 60) + minutes
        t = t % (24 * 60)
        if last_time != None:
            # print "%d - %d" % (last_time, t)
            if t < last_time:
                t += (24 * 60)
            delta = t - last_time
            if delta//60:
                time_text = "%d:%0.2d" % (delta//60, delta%60)
            else:
                time_text = ":%0.2d" % (delta%60)
            tasks[last_task].times.append(time_text)
            tasks[last_task].total += delta
            chunks = last_task.split("-")
            base_task = chunks[0] + "-TOTAL"
            tasks[base_task].times.append(time_text)
            tasks[base_task].total += delta
        task = m.group(3)
        desc = m.group(4)
        if desc:
            tasks[task].descriptions.add(desc)
        last_task = task
        last_time = t % (24 * 60)

grand_total = 0
print ''
if 'BREAK' in tasks:
    del tasks['BREAK']

base_count = {}
for task in sorted(tasks.iterkeys()):
    chunks = task.split("-")
    base = chunks[0]
    if base in base_count:
        base_count[base] = base_count[base] + 1
    else:
        base_count[base] = 1
for base in sorted(base_count.iterkeys()):
    # Unless we have two besides the total, drop it
    if base_count[base] < 3:
        del tasks[base + "-TOTAL"]

for task in sorted(tasks.iterkeys()):
    if task != 'OUT':
        desc = ". ".join(tasks[task].descriptions)
        t = tasks[task].total
        if task.find("-TOTAL") == -1:
            grand_total += t
        if t//60:
            total = "%d:%0.2d" % (t//60, t%60)
        else:
            total = ":%0.2d" % (t%60)
        if len(tasks[task].times) > 1 and task.find("-TOTAL") == -1:
            times = " ".join(tasks[task].times)
            print "    %-16s%s (%s = %s)" % (task, desc, times, total)
        else:
            print "    %-16s%s (%s)" % (task, desc, total)

print ''
print "    TOTAL           %d:%0.2d" % (grand_total//60, grand_total%60)

