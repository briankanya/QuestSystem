var/list/QuestList = list()

var/QuestDirectory = "Quests"

mob
	var
		Gold
		Experience
		list
			Quests

Quest

	var
		Description
		Giver
		GoldReward
		ExperienceReward
		Task
		AmountToCheck

		tmp
			XML
				Element
					element

	New(var/InitialElement)
		element = InitialElement

		Description = element.FirstChildText("Description")
		Giver = element.FirstChildText("Giver")
		GoldReward = text2num(element.FirstChildText("GoldReward"))
		ExperienceReward = text2num(element.FirstChildText("ExperienceReward"))
		Task = element.FirstChildText("Task")
		AmountToCheck = text2num(element.FirstChildText("AmountToCheck"))

		return ..()

	proc
		GiveQuest(var/mob/Player)
			Player.Quests.Add(src)

		CheckTask(var/mob/Player)
			if(src in Player.Quests)
				if(Player.vars["[Task]"] == AmountToCheck)
					Player.Gold += GoldReward
					Player.Experience += ExperienceReward
					Player.Quests.Remove(src)



proc
	LoadQuests()
		var/XML/Element/Root = xmlRootFromPath(QuestDirectory)

		for(var/XML/Element/QuestElement in Root.Descendants("Quest"))
			var/Quest/NewQuest = new(QuestElement)
			QuestList.Add(NewQuest)




