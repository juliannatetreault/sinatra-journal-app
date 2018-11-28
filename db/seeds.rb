julianna = User.create(username: "julianna", email: "julianna@email.com", password: "jpw")

tillman = User.create(username: "tillman", email: "tillman@email.com", password: "tpw")

lauryn = User.create(username: "lauryn", email: "lauryn@email.com", password: "lpw")

entry = julianna.journal_enteries.build(content: "Last night I slept very well--I did not wake up even once. I dreamt that my project was amazing.")
entry.save

entry = julianna.journal_enteries.build(content: "I had trouble falling asleep yesterday and awoke in the middle of the night to a terrifying nightmare. Ahhh!")
entry.save

entry = tillman.journal_enteries.build(content: "I sleep best on Sunday evenings. I slept soundly last night and cannot remember a single dream of mine.")
entry.save

entry = tillman.journal_enteries.build(content: "Unfortunately, I did not get much sleep last night. ):")
entry.save

entry = lauryn.journal_enteries.build(content: "I drank apple juice before bed last night and dreamt the craziest dreams!!")
entry.save



