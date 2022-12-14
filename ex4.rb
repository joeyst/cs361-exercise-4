# Exercise 5 Part 1 (Exception Handling)

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

class UnauditableMorningMentalState < MorningMentalState ; end

def handle_unauditable
  p "error"
  UnauditableMorningMentalState.new
end

class OkMorningMentalState < MorningMentalState ; end
class NotOkMorningMentalState < MorningMentalState ; end

def handle_audit(bedtime_mental_state)
  assert bedtime_mental_state.auditable?
  bedtime_mental_state.audit!.ok? ? OkMorningMentalState.new : NotOkMorningMentalState.new
end

def audit_sanity(bedtime_mental_state)
  if bedtime_mental_state.auditable?
    handle_audit(bedtime_mental_state)
  else
    handle_unauditable
  end
end

new_state = audit_sanity(bedtime_mental_state)

# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

class UnauditableMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  if bedtime_mental_state.auditable?
    handle_audit(bedtime_mental_state)
  else
    handle_unauditable
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work

# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

def make_candy_machine
  CandyMachine.new
end

machine = make_candy_machine
machine.prepare

if machine.ready?
  machine.make!
else
  puts "sadness"
end
