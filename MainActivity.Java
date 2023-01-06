import com.rollbar.android.Rollbar

public class MainActivity extends AppCompatActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Rollbar.init(this);
    Rollbar.instance().error(new Exception("This is a test error")); //remove this after initial testing
  }
}
