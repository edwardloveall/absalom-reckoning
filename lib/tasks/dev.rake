namespace :dev do
  desc 'Creates sample data for local development'
  task :prime do
    create_events
  end

  def create_events
    [
      { date: '4711/01/05', title: 'Fellowship enters Moria' },
      { date: '4711/01/09', title: 'Fellowship reaches Lorien' },
      { date: '4711/01/17', title: 'Passing of Gandalf' },
      { date: '4711/02/07', title: 'Fellowship leaves Lorien' },
      { date: '4711/02/17', title: 'Death of Boromir' },
      { date: '4711/02/20', title: 'Meriadoc & Pippin meet Treebeard' },
      { date: '4711/02/22', title: 'Passing of King Elessar' },
      { date: '4711/02/24', title: 'Ents destroy Isengard' },
      { date: '4711/02/26', title: 'Aragorn takes the Paths of the Dead' },
      { date: '4711/03/05', title: 'Frodo & Samwise encounter Shelob' },
      { date: '4711/03/08', title: 'Deaths of Denethor & Theoden' },
      { date: '4711/03/18', title: 'Destruction of the Ring' },
      { date: '4711/03/29', title: 'Flowering of the Mallorn' },
      { date: '4711/04/04', title: 'Gandalf visits Bilbo' },
      { date: '4711/04/17', title: 'An unexpected party' },
      { date: '4711/04/23', title: 'Crowning of King Elessar' },
      { date: '4711/05/19', title: 'Arwen leaves Lorien to wed King Elessar' },
      { date: '4711/06/11', title: 'Sauron attacks Osgiliath' },
      { date: '4711/06/13', title: 'Bilbo returns to Bag End' },
      { date: '4711/06/23', title: 'Wedding of Elessar & Arwen' },
      { date: '4711/07/04', title: 'Gandalf imprisoned by Saruman' },
      { date: '4711/07/24', title: 'The ring comes to Bilbo' },
      { date: '4711/07/26', title: 'Bilbo rescued from Wargs by Eagles' },
      { date: '4711/08/03', title: 'Funeral of King Theoden' },
      { date: '4711/08/29', title: 'Saruman enters the Shire' },
      { date: '4711/09/10', title: 'Gandalf escapes from Orthanc' },
      { date: '4711/09/14', title: 'Frodo & Bilbo\'s birthday' },
      { date: '4711/09/15', title: 'Black riders enter the Shire' },
      { date: '4711/09/18', title: 'Frodo and company rescued by Bombadil' },
      { date: '4711/09/28', title: 'Frodo wounded at Weathertop' },
      { date: '4711/10/05', title: 'Frodo crosses bridge of Mitheithel' },
      { date: '4711/10/16', title: 'Boromir reaches Rivendell' },
      { date: '4711/10/17', title: 'Council of Elrond' },
      { date: '4711/10/25', title: 'End of War of the Ring' },
      { date: '4711/11/16', title: 'Bilbo reaches the Lonely Mountain' },
      { date: '4711/12/05', title: 'Death of Smaug' },
      { date: '4711/12/16', title: 'Fellowship begins Quest' }
    ].each do |event|
      date = ArDateParser.from_date_string(event[:date])
      Event.create(occurred_on: date, title: event[:title])
    end
  end
end
