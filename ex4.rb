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

def audit_sanity(bedtime_mental_state)
  # returning error code 
  return handle_unauditable unless bedtime_mental_state.auditable?
  return OkMorningMentalState.new if bedtime_mental_state.audit!.ok?
  NotOkMorningMentalState.new
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

# relying on unwrapped dependency 
machine = CandyMachine.new
# using method on unwrapped dependency 
machine.prepare

# using method on unwrapped dependency 
if machine.ready?
  # using method on unwrapped dependency 
  machine.make!
else
  puts "sadness"
end