# 8. Getting Started With Actors

In the last chapter, you used the TaskGroup and ThrowingTaskGroup APIs to execute tasks in parallel. This lets you do work faster should a single CPU core not suffice your needs.

You explored TaskGroup‘s ingenious design, which allows you to run tasks in parallel but still collect the execution’s results in a safe, serial manner by iterating the group as an asynchronous sequence.
