class EventCreator
  COLOURS = [
    '#4B0082',
    '#00008B',
    '#DC143C',
    '#008B8B',
    '#FF4500'
  ]

  PHRASES = [
    'Congratulation, you completed a task! \o/',
    'Uhuulll, nice job.',
    'Well Done, a task was completed',
    'Nice job, one more task was completed',
    'Congratulation for completing a task'
  ]

  def self.call(task_id)
    task = Task.find(task_id)

    Event.create(task: task,
                 event_type: 'task completion',
                 payload: { colour: COLOURS.sample,
                            phrase: PHRASES.sample })

  end
end
