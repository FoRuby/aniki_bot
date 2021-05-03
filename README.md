# AnikiBot

## Info
[@GachiBuhgalterBot](https://t.me/GachiBuhgalterBot) helps you split bills for joint events.
To interact with bot, follow the [link](https://t.me/GachiBuhgalterBot) and click the ``Start`` button. For the bot to work correctly in groups, you must add the bot to the group and give it admin rights.

## Interaction
### Event form
1. To create event, run the command in Telegram group``/create_event <name> <date> <time>``. Example: ``/create_event Test Event 2020-10-10 10:00``.
   After that, the Event form will appear in the chat, with which the rest of the group can interact.
2. Now other members of the group can join the event by clicking on the ``Join`` button, or leave it through the ``Leave`` button.
3. Each event participant can pay for the event through the ``Pay`` button.
4. Each event participant can view additional information about event through the ``Info`` button.
5. Event creator(admin) can edit event information through the ``Edit`` button.

### Edit Event form
This form is available to the event administrator.
1. Administrator can close the event through the ``Close`` button. After that, the bill for the event will be evenly distributed among its participants.
2. Administrator can edit event params through the ``Update`` button.
3. Administrator can exclude participants of the event through the ``Kick User`` button.
3. Administrator can promote participants of the event through the ``Add Admin`` button.
3. Administrator can add Description to event through the ``Add Description`` button.

### User form
This form is available through the command ``/me``
1. User can view financial statistics through the ``Finance`` button.
2. User can view events statistics through the ``Statistic`` button.
3. User can request debt compensation from the selected user through the ``Compensation`` button.
4. User can pay off the debtor's debt through the ``Refill`` button.

## Changelog
See [CHANGELOG.md](https://github.com/FoRuby/aniki_bot/blob/master/CHANGELOG_EN.md) for Changelog details.

## Contributing
If you find bug, or you have an idea how to improve Aniki, please send a PR, or open a new Issue. You can also write me through command ``/feedback`` inside Telegram.
