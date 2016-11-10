<?php

// format events for recent activity feeds
function formatEvent($event=null) {
  if($event==null)
    return null;

  $eventType = EventType::loadById($event->get('event_type_id'));
  $eventTypeName = $eventType->get('name');

  $formattedEvent = 'hello';
  switch($eventTypeName) {
    case 'edit_product_title':
      $user1name = User::getUsernameById($event->get('user_1_id'));
      $product1 = Product::loadById($event->get('product_1_id'));
      $product1title = $product1->get('WineTitle');
      $date = date("m-j-y g:i a", strtotime($event->get('date_created')));
      $formattedEvent = $user1name.' edited the title of <a href="'.BASE_URL.'/products/view/'.$product1->get('id').'">'.$product1title.'</a> on '.$date.'.';
      break;

    default:
      $formattedEvent = 'Unrecognized event type.';
  }
  return $formattedEvent;
}

// generate a Follow button (or not) depending on who is logged in
function getFollowButton($username = null) {
  if($username == null)
    return null;


  if(!isset($_SESSION['username'])) {
    // user not logged in
    return '';
  } elseif($_SESSION['username'] == $username) {
      // logged-in user is the same as this user
      // so don't let user follow themselves
      return '';
  } else {
    $f = Follow::loadByUsernames($_SESSION['username'], $username);
    if($f != null) {
      // logged-in user already following this user
      return '';
    }
  }

  $str = ' <button type="button" class="follow" value="'.$username.'">Follow</button>';
  return ($str);
}
