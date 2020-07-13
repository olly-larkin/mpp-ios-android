package com.jetbrains.handson.mpp.mobile

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.ArrayAdapter
import android.widget.Spinner
import android.widget.TextView
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity(), ApplicationContract.View {

    private val presenter = ApplicationPresenter()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        presenter.onViewTaken(this)

        // Create an ArrayAdapter using the string array and a default spinner layout
        ArrayAdapter(
            this,
//            R.array.stations_array,
            android.R.layout.simple_spinner_item,
            presenter.getStationNames().sorted()
        ).also { adapter ->
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            departure_station_spinner.adapter = adapter
            destination_station_spinner.adapter = adapter
        }
    }

    override fun setLabel(text: String) {
        findViewById<TextView>(R.id.main_text).text = text
    }

    override fun updateDropDowns() {
        ArrayAdapter(
            this,
            android.R.layout.simple_spinner_item,
            presenter.getStationNames().sorted()
        ).also { adapter ->
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            departure_station_spinner.adapter = adapter
            destination_station_spinner.adapter = adapter
        }
    }

    fun getJourneyButtonClick(view: View) {
        val departCode = presenter.getStationCode(departure_station_spinner.selectedItem.toString())
        val destCode = presenter.getStationCode(destination_station_spinner.selectedItem.toString())
        val request = presenter.getTimesRequest(departCode, destCode)
        val intent = Uri.parse(request).let { webpage ->
            Intent(Intent.ACTION_VIEW, webpage)
        }
        startActivity(intent)
    }
}
