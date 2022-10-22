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

def audit_sanity(bedtime_mental_state)
  # returning error code 
  return 0 unless bedtime_mental_state.auditable?

  # returning error code as part of object 
  if bedtime_mental_state.audit!.ok?
    # writing lower-level abstraction logic in `if` statement 
    MorningMentalState.new(:ok)
  else 
    # writing lower-level abstraction logic in `if` statement 
    MorningMentalState.new(:not_ok)
  end
end

# switching on error code 
if audit_sanity(bedtime_mental_state) == 0
  puts "error"
else
  # calling again to create different type of object. Could even create an error here from mutation 
  new_state = audit_sanity(bedtime_mental_state)
end





# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  # returning `Null` as special case 
  return nil unless bedtime_mental_state.auditable?
  # conditionally returning different type of object 
  if bedtime_mental_state.audit!.ok?
    # storing error code as attribute of object, using lower-level abstraction logic (needs extracted)
    MorningMentalState.new(:ok)
  else 
    # storing error code as attribute of object, using lower-level abstraction logic (needs extracted)
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work




# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

machine = CandyMachine.new
machine.prepare

if machine.ready?
  machine.make!
else
  puts "sadness"
end